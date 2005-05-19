From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <20040622204812.3f423b24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The patch should be backed out.  (The second part of the patch, which
> removes the $sigtype = shift; is harmless)

Instead, I implemented what James Olin Oden suggested: use a global
variable to keep track of whether the fans were already restored, or
not. Please check it out and confirm it works ok.

> PS.  For anyone who's interested, I have an /etc/init.d/fancontrol
> start/stop script suitable for Fedora Core 1 for use with this perl
> script (probably also good for FC2 and recent RedHat type distros)

You can send it to the list and we will include into the CVS tree.

-- 
Jean Delvare
http://khali.linux-fr.org/
