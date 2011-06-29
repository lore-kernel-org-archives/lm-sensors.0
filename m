From: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 29 Jun 2011 17:01:23 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <4E0B5A63.90209@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/29/2011 12:28 PM, DB wrote:
> I have Fedora 14 running on my MSI 880GM-E41 board. I've run
> sensors-detect & passed the found info to (I guess) lmsensors.

Don't guess; know.  Pay attention to what sensors-detect says.  It tells 
you what sensors it finds, and what modules you need to load in 
/etc/modules.  If it didn't find any, then you don't have any supported 
sensors.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
