From: grant_lkml@dodo.com.au (Grant Coady)
Date: Fri, 20 May 2005 08:01:47 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <a1vq81p4cdmsv9sd3sc5ltjeqk8mfthiu4@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e9iUj0EZ.1116327879.1515720.khali@localhost>
In-Reply-To: <e9iUj0EZ.1116327879.1515720.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,
On Wed, 18 May 2005 00:36:18 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
>Here is a patch against it87, since it seems to have many more device
>attributes than lm90. The size difference:

And the sysfs crossref is cleaner with it87:

it87.c       alarms                      R
it87.c       cpu0_vid                    R
it87.c       fan1_div                    RW *
it87.c       fan1_input                  R  *
it87.c       fan1_min                    RW *
it87.c       in0_input                   R  *
it87.c       in0_max                     RW *
it87.c       in0_min                     RW *
it87.c       pwm1                        RW *
it87.c       pwm1_enable                 RW *
it87.c       temp1_input                 R  *
it87.c       temp1_max                   RW *
it87.c       temp1_min                   RW *
it87.c       temp1_type                  RW *
it87.c       vrm                         RW

Asterisk is for dynamics, attributes without '*' are singletons.

--Grant.

