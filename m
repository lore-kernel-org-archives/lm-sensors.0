From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 11 Sep 2012 05:07:29 +0000
Subject: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="_000_4D68720C2E767A4AA6A8796D42C8EB591B6F8FBGSMSX101garcorpi_"
List-Id: <lm-sensors.vger.kernel.org>
To: "Guenter Roeck (guenter.roeck@ericsson.com)" <guenter.roeck@ericsson.com>, "Guenter Roeck (linux@roeck-us.net)" <linux@roeck-us.net>, "Jean Delvare
	(khali@linux-fr.org)" <khali@linux-fr.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors (lm-sensors@lm-sensors.org)" <lm-sensors@lm-sensors.org>

--===============5839877007958540778==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4D68720C2E767A4AA6A8796D42C8EB591B6F8FBGSMSX101garcorpi_"

--_000_4D68720C2E767A4AA6A8796D42C8EB591B6F8FBGSMSX101garcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jean/Guenter,

In thermal_sys.c we have a CONFIG_THERMAL_HWMON.
If enabled, this creates sysfs nodes for thermal zones inside
hwmon. Do we need this functionality inside thermal_sys.c ?
Or is it Ok to remove this ?

I wanted to know your opinion before submitting a patch.

Thanks,
Durga

--_000_4D68720C2E767A4AA6A8796D42C8EB591B6F8FBGSMSX101garcorpi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"ProgId" content=3D"Word.Document">
<meta name=3D"Generator" content=3D"Microsoft Word 14">
<meta name=3D"Originator" content=3D"Microsoft Word 14">
<link rel=3D"File-List" href=3D"cid:filelist.xml@01CD9009.7139C810"><!--[if=
 gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
<o:DoNotRelyOnCSS/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:SpellingState>Clean</w:SpellingState>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:PunctuationKerning/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<m:mathPr>
<m:mathFont m:val=3D"Cambria Math"/>
<m:brkBin m:val=3D"before"/>
<m:brkBinSub m:val=3D"&#45;-"/>
<m:smallFrac m:val=3D"off"/>
<m:dispDef/>
<m:lMargin m:val=3D"0"/>
<m:rMargin m:val=3D"0"/>
<m:defJc m:val=3D"centerGroup"/>
<m:wrapIndent m:val=3D"1440"/>
<m:intLim m:val=3D"subSup"/>
<m:naryLim m:val=3D"undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true" DefSemi=
Hidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99" LatentStyleCount=3D=
"267">
<w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 3"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 4"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 5"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 6"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 7"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 8"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D"he=
ading 9"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 1"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 2"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 3"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 4"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 5"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 6"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 7"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>
<w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" Name=3D"c=
aption"/>
<w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>
<w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default Paragraph F=
ont"/>
<w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"/>
<w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>
<w:LsdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"59" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Table Grid"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Placehold=
er Text"/>
<w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"false" Unhide=
WhenUsed=3D"false" QFormat=3D"true" Name=3D"No Spacing"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Revision"=
/>
<w:LsdException Locked=3D"false" Priority=3D"34" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>
<w:LsdException Locked=3D"false" Priority=3D"29" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"30" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium List 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Dark List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" Name=3D"Colorful Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"19" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"21" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"31" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"32" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"33" SemiHidden=3D"false" Unhid=
eWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Title"/>
<w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliography"/>
<w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"true" Name=3D"T=
OC Heading"/>
</w:LatentStyles>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Century Gothic";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520092929 1073786111 9 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"tab-interval:.=
5in">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">Hi Jean/Guenter,<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">In
<span class=3D"SpellE">thermal_sys.c</span> we have a CONFIG_THERMAL_HWMON.=
<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">If enabled, this creates sysfs nodes for thermal zones insid=
e<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><span class=3D"SpellE"><font size=3D"2" face=3D"Cali=
bri"><span style=3D"font-size:11.0pt">hwmon</span></font></span>. Do we nee=
d this functionality inside
<span class=3D"SpellE">thermal_sys.c</span> ?<o:p></o:p></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">Or is it Ok to remove this ?<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">I wanted to know your opinion before submitting a patch.<o:p=
></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt"><o:p>&nbsp;</o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">Thanks,<o:p></o:p></span></font></p>
<p class=3D"MsoNormal"><font size=3D"2" face=3D"Calibri"><span style=3D"fon=
t-size:11.0pt">Durga
<o:p></o:p></span></font></p>
</div>
</body>
</html>

--_000_4D68720C2E767A4AA6A8796D42C8EB591B6F8FBGSMSX101garcorpi_--


--===============5839877007958540778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5839877007958540778==--
