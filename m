From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <3EE7C67A.4040703@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think things are getting into shape here after a lot of work.
Maybe we can do a release in a week or two?

Open issues, please comment or add to list:

- sensors-detect "UTF" issue
- libsensors numbering because of binary incompatibility..... go to 1.5.0 or 2.0.0?
- Delete sensors.h in sensors/include, move files?
- Incompatibility w/ 2.4 kernel i2c structs
- Need testing against kernel 2.4.9
- Mkpatch - abandon, fix, what?
- Update README, INSTALL, etc.
