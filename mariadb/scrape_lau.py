#!/usr/bin/env python3
"""
LAU Catalogue Scraper using Playwright
Run: python3 scrape_lau.py
Output: scraped_courses.sql
"""

import re
import time
from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright

BASE_URL = "https://catalog.lau.edu.lb/2025-2026/courses/{prefix}.php"

DEPARTMENTS = [
    ("coe",  "Computer Engineering",              "ENG"),
    ("ele",  "Electrical Engineering",            "ENG"),
    ("mee",  "Mechanical Engineering",            "ENG"),
    ("cie",  "Civil Engineering",                 "ENG"),
    ("che",  "Chemical Engineering",              "ENG"),
    ("ine",  "Industrial Engineering",            "ENG"),
    ("mce",  "Mechatronics",                      "ENG"),
    ("gne",  "General Engineering",               "ENG"),
    ("enm",  "Engineering Management",            "ENG"),
    ("mth",  "Mathematics",                       "LAS"),
    ("phy",  "Physics",                           "LAS"),
    ("chm",  "Chemistry",                         "LAS"),
    ("bio",  "Biology",                           "LAS"),
    ("csc",  "Computer Science",                  "LAS"),
    ("eng",  "English",                           "LAS"),
    ("ara",  "Arabic",                            "LAS"),
    ("sta",  "Statistics",                        "LAS"),
    ("phl",  "Philosophy",                        "LAS"),
    ("hst",  "History",                           "LAS"),
    ("pol",  "Political Science",                 "LAS"),
    ("psy",  "Psychology",                        "LAS"),
    ("soc",  "Sociology",                         "LAS"),
    ("eco",  "Economics",                         "LAS"),
    ("env",  "Environmental Science",             "LAS"),
    ("cys",  "Cybersecurity",                     "LAS"),
    ("dsc",  "Data Science",                      "LAS"),
    ("aai",  "Applied Artificial Intelligence",   "LAS"),
    ("acc",  "Accounting",                        "BUS"),
    ("fin",  "Finance",                           "BUS"),
    ("mgt",  "Management",                        "BUS"),
    ("mkt",  "Marketing",                         "BUS"),
    ("hrm",  "Human Resources Management",        "BUS"),
    ("ibs",  "International Business",            "BUS"),
    ("qba",  "Quantitative Business Analysis",    "BUS"),
    ("opm",  "Operations and Production Mgmt",    "BUS"),
    ("arch", "Architecture",                      "ARCH"),
    ("inar", "Interior Design",                   "ARCH"),
    ("pha",  "Pharmacy",                          "PHAR"),
    ("nur",  "Nursing",                           "NUR"),
    ("com",  "Communication",                     "COMM"),
    ("jsc",  "Multimedia Journalism",             "COMM"),
]

SCHOOLS = {
    "ENG":  "School of Engineering",
    "LAS":  "School of Arts and Sciences",
    "BUS":  "Suliman S. Olayan School of Business",
    "ARCH": "School of Architecture and Design",
    "PHAR": "School of Pharmacy",
    "NUR":  "School of Nursing",
    "COMM": "School of Communication Arts",
}


def parse_credits(text):
    m = re.search(r",\s*(\d+)\s*cr", text, re.IGNORECASE)
    if m:
        return int(m.group(1))
    m = re.search(r"(\d+)\s*cr", text, re.IGNORECASE)
    if m:
        return int(m.group(1))
    return 3


def parse_prereqs(text):
    text = re.sub(r"(?i)(co-requisite|concurrent with|prerequisite[s]?)[:\s]*", "", text)
    codes = re.findall(r"\b([A-Z]{2,5})\s*(\d{3}[A-Z]?)\b", text)
    return [f"{p} {n}" for p, n in codes]


def escape(s):
    return s.replace("'", "''") if s else ""


def scrape_department(page, prefix):
    url = BASE_URL.format(prefix=prefix)
    try:
        response = page.goto(url, wait_until="domcontentloaded", timeout=30000)
        if response.status == 404:
            print(f"  [SKIP] {prefix} → 404")
            return []
        page.wait_for_timeout(1000)
    except Exception as e:
        print(f"  [ERROR] {prefix} → {e}")
        return []

    soup = BeautifulSoup(page.content(), "html.parser")

    # with open(f"debug_{prefix}.html", "w") as f:
    #     f.write(page.content())
    # print(f"  [DEBUG] h3 count: {len(soup.find_all('h3'))}, h2: {len(soup.find_all('h2'))}, title: {soup.title.string if soup.title else 'none'}")
    
    courses = []

    for h3 in soup.find_all("h3"):
        span = h3.find("span", class_="crn")
        if not span:
            continue

        code = span.get_text(strip=True)          # e.g. "COE312"
        name = h3.get_text(strip=True).replace(code, "").strip()  # rest of h3 text

        # parse prefix and number from code
        m = re.match(r"([A-Z]{2,5})(\d{3}[A-Z0-9]*)", code)
        if not m:
            continue

        code_prefix  = m.group(1)
        abbreviation = f"{code_prefix} {m.group(2)}"

        credits = 3
        h4 = h3.find_next_sibling("h4")
        if h4:
            credits = parse_credits(h4.get_text())

        description_parts = []
        prereq_abbrevs = []

        sibling = h3.find_next_sibling()
        while sibling and sibling.name not in ("h3", "h2"):
            if sibling.name == "p":
                text = sibling.get_text(" ", strip=True)
                low = text.lower()
                if any(kw in low for kw in ("prerequisite", "co-requisite", "concurrent")):
                    prereq_abbrevs = parse_prereqs(text)
                else:
                    if text:
                        description_parts.append(text)
            sibling = sibling.find_next_sibling()

        courses.append({
            "abbreviation":  abbreviation,
            "name":          name,
            "credits":       credits,
            "description":   " ".join(description_parts).strip(),
            "prerequisites": prereq_abbrevs,
            "dept_prefix":   code_prefix.upper(),
        })

    print(f"  [{prefix.upper():6}] {len(courses)} courses")
    return courses


def main():
    all_courses = []

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
        )
        page = context.new_page()

        # warm up — visit the main page first so Cloudflare sets cookies
        print("Warming up browser...")
        page.goto("https://catalog.lau.edu.lb/2025-2026/", wait_until="domcontentloaded", timeout=30000)
        page.wait_for_timeout(2000)

        for prefix, dept_name, school_abbr in DEPARTMENTS:
            print(f"Scraping {prefix.upper()} — {dept_name} ...")
            courses = scrape_department(page, prefix)
            for c in courses:
                c["school_abbr"] = school_abbr
                c["dept_name"]   = dept_name
            all_courses.extend(courses)
            time.sleep(0.8)

        browser.close()

    # deduplicate
    seen = set()
    unique = []
    for c in all_courses:
        if c["abbreviation"] not in seen:
            seen.add(c["abbreviation"])
            unique.append(c)

    print(f"\nTotal unique courses: {len(unique)}")

    # ID maps
    school_abbrs  = list(dict.fromkeys(s for _, _, s in DEPARTMENTS))
    school_id_map = {a: i+1 for i, a in enumerate(school_abbrs)}

    scraped_prefixes = list(dict.fromkeys(c["dept_prefix"] for c in unique))
    dept_id_map = {}
    dept_rows   = []
    for i, pfx in enumerate(scraped_prefixes):
        did = i + 1
        dept_id_map[pfx] = did
        dept_name = next((n for p, n, _ in DEPARTMENTS if p.upper() == pfx), pfx)
        school_a  = next((s for p, _, s in DEPARTMENTS if p.upper() == pfx), "LAS")
        dept_rows.append((did, dept_name, pfx, school_id_map[school_a]))

    course_id_map = {c["abbreviation"]: i+1 for i, c in enumerate(unique)}

    # Build SQL
    out = []
    out.append("USE course_registration;\n")

    # out.append("-- SCHOOLS")
    # out.append("INSERT INTO school (school_id, name, abbreviation) VALUES")
    # vals = [f"({school_id_map[a]}, '{escape(SCHOOLS[a])}', '{a}')" for a in school_abbrs]
    # out.append(",\n".join(vals) + ";\n")

    out.append("-- DEPARTMENTS")
    out.append("INSERT INTO department (department_id, name, abbreviation, school_id) VALUES")
    vals = [f"({did}, '{escape(dn)}', '{da}', {sid})" for did, dn, da, sid in dept_rows]
    out.append(",\n".join(vals) + ";\n")

    out.append("-- COURSES")
    out.append("INSERT INTO course (course_id, name, abbreviation, credits, description, department_id) VALUES")
    vals = []
    for c in unique:
        cid  = course_id_map[c["abbreviation"]]
        did  = dept_id_map.get(c["dept_prefix"], 1)
        desc = escape(c["description"][:1000]) if c["description"] else None
        desc_sql = f"'{desc}'" if desc else "NULL"
        vals.append(
            f"({cid}, '{escape(c['name'][:148])}', '{escape(c['abbreviation'])}', "
            f"{c['credits']}, {desc_sql}, {did})"
        )
    out.append(",\n".join(vals) + ";\n")

    prereq_rows = []
    skipped = []
    for c in unique:
        cid = course_id_map[c["abbreviation"]]
        for pa in c["prerequisites"]:
            if pa in course_id_map:
                pid = course_id_map[pa]
                if cid != pid:
                    prereq_rows.append((cid, pid))
            else:
                skipped.append(f"{c['abbreviation']} → {pa}")

    prereq_rows = sorted(set(prereq_rows))

    if prereq_rows:
        out.append("-- PREREQUISITES")
        out.append("INSERT INTO prerequisite (course_id, prerequisite_id) VALUES")
        out.append(",\n".join(f"({cid}, {pid})" for cid, pid in prereq_rows) + ";\n")

    if skipped:
        out.append("-- Skipped prereqs (outside scraped scope):")
        for s in skipped:
            out.append(f"--   {s}")

    sql = "\n".join(out)
    with open("scraped_courses.sql", "w", encoding="utf-8") as f:
        f.write(sql)

    print(f"Prerequisites: {len(prereq_rows)}, skipped: {len(skipped)}")
    print("Done → scraped_courses.sql")


if __name__ == "__main__":
    main()