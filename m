From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Ticket #1144
Message-Id: <3E6A762C.8060108@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1126.10.20.10.15.1046083175.squirrel@deathstar.of.rocnet.de>
In-Reply-To: <1126.10.20.10.15.1046083175.squirrel@deathstar.of.rocnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

tkt 1137 has an identical problem.
no solution yet.
Be sure you are using /usr/local/bin/sensors and there are no old libsensors
versions in /usr/lib.

Claus Rosenberger wrote:
> Hello,
> 
> i use version 2.7.0 of your website. You can see it in the dmesg output.
> What i have done was first time to do the mkpatch manually and patch the
> kernel, the second time i downloaded the patches from your website. Both
> times i updated i2c before of course.
> 
> The parameter you gave didn't help, sorry.
> 
> What can i do or which informations i can collect to find a solution.
> 
> Thanks a lot
> 
> Claus
> 
> 
