From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: Compiling lm_sensors module with gcc 3.3. (A problem and
Message-Id: <20030622152443.GB6801@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EF4DD25.6000802@yk.rim.or.jp>
In-Reply-To: <3EF4DD25.6000802@yk.rim.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Mark D. Studebaker <mds@paradyne.com> [2003-06-22 10:51:35 -0400]:
> would you please send us the entire output of 'make' so we can clean up the warnings. Thanks.

> Ishikawa wrote:
> > 
> > Thank you for your quick response.
> > 
> > I downloaded the Makefile and etc/config.c
> > and retried compiling lm_sensors 2.7.0 using gcc 3.3.
                                     ^^^^^

(mds - correct me if I'm wrong here)

If you're going to send the output of make, please get the latest
CVS of everything (i2c and lm_sensors2) not just these two files.
We've already cleaned up a lot of warnings.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
