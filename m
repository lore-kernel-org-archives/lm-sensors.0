From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: decode-edid perl problems
Message-Id: <20030720233236.1d669237.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F19DBE5.7070508@paradyne.com>
In-Reply-To: <3F19DBE5.7070508@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> perl 5.005
> 
> Not enough arguments for syswrite at ./decode-edid.pl line 111, near
> "$output;" Not enough arguments for syswrite at ./decode-edid.pl line
> 114, near ""\n";" Execution of ./decode-edid.pl aborted due to
> compilation errors.

Really strange. This is supposed to work with perl 5.005_03. Please try
adding a third parameter to the syswrite calls:
  syswrite PIPE, "\n";
becomes:
  syswrite (PIPE, "\n", length ("\n"));
and so on.

In sensors-detect we use that form and it seem to work for you. If it
works I'll commit the changes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
