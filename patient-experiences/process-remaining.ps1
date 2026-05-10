# Script to process remaining PEARS patient stories (31-54)
# Each story has been fetched and saved as content.md files

$stories = @(
    @{Num=31; Name="Sinead McLeish"; Step=225; Url="https://exstent.com/story/sinead-mcleish/"; Desc="40yo mother of two, Royal Brompton Hospital"},
    @{Num=32; Name="Paul Thompson"; Step=226; Url="https://exstent.com/story/paul-thompson/"; Desc="Badminton player"},
    @{Num=33; Name="Amy Rees"; Step=227; Url="https://exstent.com/story/amy-rees/"; Desc="32yo, 2 months post-op"},
    @{Num=34; Name="Scott Meikle"; Step=228; Url="https://exstent.com/story/scott-meikle/"; Desc="40yo from Glasgow, putative Marfan"},
    @{Num=35; Name="Paul"; Step=229; Url="https://exstent.com/story/paul/"; Desc="20-something, active, contact sports"},
    @{Num=36; Name="Billy Lindfield"; Step=230; Url="https://exstent.com/story/billy-lindfield/"; Desc="18yo, June 2013"},
    @{Num=37; Name="Hayden and Isaac Grainger"; Step=231; Url="https://exstent.com/story/hayden-and-isaac-grainger/"; Desc="16yo identical twins"},
    @{Num=38; Name="Nic"; Step=232; Url="https://exstent.com/story/nic/"; Desc="32yo Australian opera singer"},
    @{Num=39; Name="Jeni Bennett"; Step=233; Url="https://exstent.com/story/jeni-bennett/"; Desc="Discovered condition reaching up"},
    @{Num=40; Name="Rosanna Lawes"; Step=234; Url="https://exstent.com/story/rosanna-lawes/"; Desc="Family with Marfan, dad's aorta 70mm"},
    @{Num=41; Name="Dan Uzelac"; Step=235; Url="https://exstent.com/story/dan-uzelac/"; Desc="Making life easy for everyone"},
    @{Num=42; Name="Kathy Baurley"; Step=236; Url="https://exstent.com/story/kathy-baurley/"; Desc="48yo single mum with two boys"},
    @{Num=43; Name="Alex Milton"; Step=237; Url="https://exstent.com/story/alex-milton/"; Desc="Lost brother Mark to Marfan"},
    @{Num=44; Name="Michael V"; Step=238; Url="https://exstent.com/story/michael-v/"; Desc="Diagnosed at 30"},
    @{Num=45; Name="Andrew Ellis"; Step=239; Url="https://exstent.com/story/andrew-ellis/"; Desc="2 months post-op"},
    @{Num=46; Name="Sam Berry"; Step=240; Url="https://exstent.com/story/sam-berry/"; Desc="Diagnosed Marfan at 14"},
    @{Num=47; Name="Malcolm Richards"; Step=241; Url="https://exstent.com/story/malcolm-richards/"; Desc="Dec 2008, aged 26"},
    @{Num=48; Name="Camilla Allen"; Step=242; Url="https://exstent.com/story/camilla-allen/"; Desc="Aortic root 4.3cm"},
    @{Num=49; Name="Ami Coxill-Moore"; Step=243; Url="https://exstent.com/story/ami-coxill-moore/"; Desc="17yo, Marfan since baby"},
    @{Num=50; Name="Graham Cade"; Step=244; Url="https://exstent.com/story/graham-cade/"; Desc="Marfan, regular check-ups"},
    @{Num=51; Name="Sam Stillman"; Step=245; Url="https://exstent.com/story/sam-stillman/"; Desc="Found out 2006, aorta 4.0cm"},
    @{Num=52; Name="Peter Barker"; Step=246; Url="https://exstent.com/story/peter-barker/"; Desc="Two daughters with Marfan"},
    @{Num=53; Name="Emma Barker"; Step=247; Url="https://exstent.com/story/emma-barker/"; Desc="23yo, Marfan"},
    @{Num=54; Name="Tal Golesworthy"; Step=248; Url="https://exstent.com/story/tal-golesworthy/"; Desc="PEARS inventor, patient #1"}
)

$basePath = "C:\Users\highf\.gemini\antigravity\brain\65cd13fb-2bc5-486e-8d4d-64539ffb4273\.system_generated\steps"
$outDir = "d:\Projects\Surgery\patient-experiences"

foreach ($story in $stories) {
    $contentFile = Join-Path $basePath "$($story.Step)\content.md"
    if (Test-Path $contentFile) {
        $content = Get-Content $contentFile -Raw -Encoding UTF8
        
        # Extract story text between "[Patient stories]..." line and "## Share this story"
        $storyMatch = [regex]::Match($content, '\[Patient stories\]\(https://exstent\.com/medical-devices/exovasc/patient-stories/\)\s*\n\s*\n(.*?)(?=\n## Share this story)', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        if ($storyMatch.Success) {
            $storyText = $storyMatch.Groups[1].Value.Trim()
        } else {
            # Fallback: try to find content between line 304 marker and Share
            $lines = $content -split "`n"
            $startIdx = -1
            $endIdx = -1
            for ($i = 0; $i -lt $lines.Count; $i++) {
                if ($lines[$i] -match '^\[Patient stories\]') { $startIdx = $i + 1 }
                if ($lines[$i] -match '^## Share this story') { $endIdx = $i - 1; break }
            }
            if ($startIdx -ge 0 -and $endIdx -ge $startIdx) {
                $storyText = ($lines[$startIdx..$endIdx] | Where-Object { $_.Trim() -ne '' }) -join "`n"
            } else {
                $storyText = "CONTENT EXTRACTION FAILED - Please review manually"
            }
        }
        
        $slug = ($story.Name -replace '\s+', '-' -replace '[^a-zA-Z0-9-]', '').ToLower()
        $fileName = "{0:D2}-{1}.txt" -f $story.Num, $slug
        $outFile = Join-Path $outDir $fileName
        
        $header = @"
PEARS Patient Story: $($story.Name)
Source: $($story.Url)
Brief: $($story.Desc)

================================================================================

"@
        $fullContent = $header + $storyText
        
        [System.IO.File]::WriteAllText($outFile, $fullContent, [System.Text.Encoding]::UTF8)
        Write-Host "Created: $fileName"
    } else {
        Write-Host "MISSING: $contentFile"
    }
}

Write-Host "`nDone! Created files for stories 31-54."
