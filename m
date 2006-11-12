From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 12 Nov 2006 14:01:42 +0000
Subject: [lm-sensors] sensors.conf syntax: anyone use escape sequences?
Message-Id: <20061112140142.GB8009@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

This is a question about sensors.conf syntax:

For a quoted string, libsensors currently accepts C language escape sequences
like '\n' for newline, etc.  It also accepts octal escapes, like '\015', but
for some reason it doesn't accept hex escapes, like '\x20'.

Question: is anyone actually using these escapes?

I wouldn't mind getting rid of them.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


