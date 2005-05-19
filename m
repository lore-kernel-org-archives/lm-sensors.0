From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Missing PGP keys?
Message-Id: <40E069FA.7030202@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c45d10$823e7e10$07dc6551@endyvlwz58nhmy>
In-Reply-To: <000001c45d10$823e7e10$07dc6551@endyvlwz58nhmy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'll take another look.  From my last examination, it appeared that some 
browsers were trying to parse and interpret the PGP (like look for a 
public key or something) instead of treating it as a regular file.  I'll 
see if I can tweak the mime-type or content-disposition to make those 
browsers behave.


Phil

Jean Delvare wrote:
>>Dear Sensors,
>>              apologies if I'm doing something stupid
>>(I don't think so).  All links to PGP keys from the page
>>
>>http://www2.lm-sensors.nu/~lm78/download.html
>>
>>lead to apparently empty pages.  I think the page
>>actually doesn't exist, but is being faked as an
>>empty page by the server, since attempting to
>>download the PGP keys directly to disc fails
>>*immediately* (the "Save as..." dialogue appears
>>and then disappears at once).
>>
>>I am using someone else's browser (IE5 on Windows
>>XP), but I doubt whether this is very relevant.
> 
> 
> You're correct, I see the same behavior here with a real browser on an
> almost real OS ;)
> 
> Phil, can you please take a look?
> 
> Jean Delvare
> 
