From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: smart HDD
Message-Id: <3F1C0964.F500FCC3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721154832.43dd6564.khali@linux-fr.org>
In-Reply-To: <20030721154832.43dd6564.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've implemented HDD temperature in 'sensors', I never checked it in.
It's pretty neat. 

I never checked it in because it has some problems, has to be run as root,
and (as you pointed out) it's debatable what the relationship is to
our project. It's definitely sensor-related but not i2c-related.

If you want I can email my version to the list.

Jean Delvare wrote:
> 
> Hi all,
> 
> On our new drivers page, there is an entry for SMART HDD temperature,
> that read:
> A program could be written to present the temperature using i2c-proc and
> 'sensors'.
> 
> I'm interested in that, since I think one of my hdd would support it.
> What's the idea however? The sensor is not found on an I2C bus AFAIK,
> there are specialized tools to retrive SMART data
> (http://www.linux-ide.org/smart.html). So what's the link with our
> project?
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
