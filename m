From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: sensors, algorithm and sysfs
Message-Id: <400DE6CF.7020500@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074605882.400d2f3a51417@imp.gcu.info>
In-Reply-To: <1074605882.400d2f3a51417@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed

Jean Delvare wrote:
> Hi all,
> 
> I plan to modify sensors so that it doesn't display the algorithm by
> default.
> 
> Back in time, I once proposed that adapter and algorithm shouldn't be
> displayed by default. It was objected that they were very useful for
> debugging purposes (i.e. analyze user reports). I had to agree and
> although I added an option to hide adapter and algorithm, it wasn't the
> default.
> 
> With sysfs, things have changed a bit, because sysfs usually doesn't
> provide the algorithm. I think that most users get confused by the
> message shown, although we know it isn't an error. This is the reason
> why I would like not to display it by default.
> 
> This time, I don't think that it raises any problem related to the
> ability to debug/support, because we can deduce the algorithm from the
> adapter.
> 
> For now we have:
> default : display both adapter and algorithm
> -A      : hide both
> 
> I propose:
> default : display adapter only
> -A      : hide both
> -a      : display both
> 
> Anyone speak up if you have counterarguments.
> 
