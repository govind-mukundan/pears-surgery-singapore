import os
import glob
import re

directory = r"d:\Projects\Surgery\patient-experiences"
files = glob.glob(os.path.join(directory, "[0-5][0-9]-*.txt"))

timeline_keywords = [
    "day", "days", "week", "weeks", "month", "months", "hour", "hours", "year", "years",
    "hospital", "discharged", "discharge", "icu", "hdu", "ward", "clinic",
    "walk", "walking", "drive", "driving", "work", "working", "slept", "sleep", "recovery"
]

def extract_sentences(text, keywords):
    # Basic sentence splitter
    sentences = re.split(r'(?<=[.!?])\s+', text.replace('\n', ' '))
    extracted = []
    for sentence in sentences:
        s_lower = sentence.lower()
        # Check if sentence contains any timeframe keyword AND a recovery keyword
        time_match = any(re.search(r'\b' + kw + r'\b', s_lower) for kw in ["day", "days", "week", "weeks", "month", "months", "hour", "hours"])
        action_match = any(re.search(r'\b' + kw + r'\b', s_lower) for kw in ["hospital", "discharge", "discharged", "icu", "hdu", "ward", "walk", "walking", "drive", "driving", "work", "working", "recovery", "home"])
        
        if time_match and action_match:
            extracted.append(sentence.strip())
            
    return extracted

report_lines = []
report_lines.append("# Recovery Timeline Extraction\n")

for file_path in sorted(files):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract metadata header
    name_match = re.search(r'PEARS Patient Story: (.*)', content)
    name = name_match.group(1) if name_match else os.path.basename(file_path)
    
    sentences = extract_sentences(content, timeline_keywords)
    if sentences:
        report_lines.append(f"### {name}")
        for s in sentences:
            report_lines.append(f"- {s}")
        report_lines.append("")

out_path = os.path.join(directory, "timeline_analysis.md")
with open(out_path, 'w', encoding='utf-8') as f:
    f.write("\n".join(report_lines))

print(f"Extraction complete. Found data for {len(files)} files. Saved to {out_path}")
