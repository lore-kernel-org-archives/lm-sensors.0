From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Call for 2.8.2 soon
Message-Id: <3FC26C7C.3010404@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:


> 
> Here comes my TODO list:
> 
> 1* /proc write problem in libsensors.
> 2* Get rid of dmidecode dependency in sensors-detect.
> 3* Remove ACPI method in sensors-detect, leave only VPD in.
> 4* The limit init removal left a few variables unused. Fix that.
> 5* Sysfs support in sensors-detect?
> 
> Point #1 can obviously be postponed, since it's probable I won't find
> the solution in time.
> Point #5 would require me to have a working Linux 2.6.0-testX kernel,
> which I don't really have at the moment.

How about if I tar up my /sys and send it to you for testing?
Then you could test on 2.4.
