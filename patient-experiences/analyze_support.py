import os
import glob
import re

directory = r"d:\Projects\Surgery\patient-experiences"
files = glob.glob(os.path.join(directory, "[0-5][0-9]-*.txt"))

support_keywords = [
    "alone", "help", "support", "wife", "husband", "partner", "mum", "mother", "dad", "father",
    "friend", "lift", "lifting", "reach", "reaching", "carry", "cook", "cooking", "clean", "cleaning",
    "bath", "bathe", "shower", "dress", "dressing", "shoe", "shoes", "drive", "driving", "stairs",
    "bed", "pillow", "sleep", "heavy"
]

def extract_support(text, keywords):
    sentences = re.split(r'(?<=[.!?])\s+', text.replace('\n', ' '))
    extracted = []
    for sentence in sentences:
        s_lower = sentence.lower()
        # Look for combinations of daily living tasks and difficulty/help
        if any(re.search(r'\b' + kw + r'\b', s_lower) for kw in keywords):
            # Try to filter for actual struggles or support mentions
            if any(re.search(r'\b' + kw + r'\b', s_lower) for kw in ["help", "couldn't", "cannot", "hard", "difficult", "unable", "struggle", "need", "needed", "pillow", "lift", "heavy", "bath", "shoe"]):
                extracted.append(sentence.strip())
    return extracted

report_lines = []
report_lines.append("# Support and Daily Living Analysis\n")

for file_path in sorted(files):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    name_match = re.search(r'PEARS Patient Story: (.*)', content)
    name = name_match.group(1) if name_match else os.path.basename(file_path)
    
    sentences = extract_support(content, support_keywords)
    # Deduplicate and clean up
    sentences = list(dict.fromkeys(sentences))
    
    if sentences:
        report_lines.append(f"### {name}")
        for s in sentences[:10]:
            report_lines.append(f"- {s}")
        report_lines.append("")

out_path = os.path.join(directory, "support_analysis.md")
with open(out_path, 'w', encoding='utf-8') as f:
    f.write("\n".join(report_lines))

print(f"Extraction complete. Saved to {out_path}")
