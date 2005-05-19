From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: sensors.c
Message-Id: <3ED8C09D.8080309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kyosti deleted everything in kernel/sensors.c.
This was an initialization module used in patched kernels.

Does anybody have an idea if mkpatch and mkpatched kernels
will work? How does the initialization work with compiled-in
sensors in a mkpatched kernel?

If somebody would volunteer to test out mkpatch on i2c lk2-4
and on sensors and report results that would be great.
We have to figure out what to do with mkpatch.

I'm working this weekend on the last two months of email and
a month of tickets to try and get things into shape
for a release.

mds
