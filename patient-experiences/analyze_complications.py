import os
import glob
import re

directory = r"d:\Projects\Surgery\patient-experiences"
files = glob.glob(os.path.join(directory, "[0-5][0-9]-*.txt"))

complication_keywords = [
    "complication", "complications", "fever", "temperature", "infection", "arrhythmia", "fibrillation", "afib",
    "pain", "painful", "nausea", "vomit", "vomiting", "sick", "sickness", "fluid", "effusion", 
    "pleural", "pericardial", "tachycardia", "blood pressure", "headache", "dizzy", "dizziness",
    "sweat", "sweating", "sleep", "insomnia", "anxiety", "depression", "ptsd", "nightmare"
]

def extract_complications(text, keywords):
    sentences = re.split(r'(?<=[.!?])\s+', text.replace('\n', ' '))
    extracted = []
    for sentence in sentences:
        s_lower = sentence.lower()
        if any(re.search(r'\b' + kw + r'\b', s_lower) for kw in keywords):
            # Ignore sentences that say "no complications" or "no pain"
            if not re.search(r'\bno\s+(complication|pain|infection|fever|sickness)\b', s_lower) and not re.search(r'\bwithout\s+complication', s_lower):
                extracted.append(sentence.strip())
    return extracted

report_lines = []
report_lines.append("# Complication Analysis\n")

for file_path in sorted(files):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    name_match = re.search(r'PEARS Patient Story: (.*)', content)
    name = name_match.group(1) if name_match else os.path.basename(file_path)
    
    sentences = extract_complications(content, complication_keywords)
    if sentences:
        report_lines.append(f"### {name}")
        for s in sentences[:8]: # Limit to 8 sentences per person to avoid overload
            report_lines.append(f"- {s}")
        if len(sentences) > 8:
            report_lines.append(f"- *(... and {len(sentences)-8} more references)*")
        report_lines.append("")

out_path = os.path.join(directory, "complications_analysis.md")
with open(out_path, 'w', encoding='utf-8') as f:
    f.write("\n".join(report_lines))

print(f"Extraction complete. Saved to {out_path}")
