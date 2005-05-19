From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: call for 2.6.6
Message-Id: <3DD5999A.49A03347@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Let's set a deadline of Sunday night 11/24 to get stuff checked in.
Then a couple of days to look for problems.
Then Phil can release sometime over the long Thanksgiving weekend?
(11/28-12/1)

I want to again raise the question of dependency on i2c-2.6.6 because
of SENSORS_INSMOD_8 in adm1021. If we leave this in, we will require
users
to upgrade i2c as well which will lead to more support issues. We can
attempt to minimize by putting big fat warnings on the home page and 
download page. We may also wish to bump up to 2.7.0 instead of 2.6.6?

The advantage is we can remove some #ifndef cruft in the drivers.
Our current dependency is on i2c-2.6.1 which is 15 months old.

Would like to hear opinions on these issues.

mds
