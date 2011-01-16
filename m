From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 16 Jan 2011 07:22:22 +0000
Subject: Re: [lm-sensors] support for emc1023
Message-Id: <20110116072222.GB27859@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D31E890.7030004@gmail.com>
In-Reply-To: <4D31E890.7030004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 15, 2011 at 01:33:52PM -0500, Anish Patel wrote:
> Hi all,
>      i've attached a patch for the sensors-detect script that will 
> detect the SMSC EMC1023 smbus Thermal IC.
> also attached is a driver, please let me know if i did anything wrong in 
> it or did not give anyone proper credit,
> I was the tmp401 driver for a framework.
> 
> 
> Regards,
> Anish
> 

Hi,

please provide separate patches for sensors-detect and for the kernel driver.

For the kernel driver, please read Documentation/SubmittingDrivers,
Documentation/SubmitChecklist, and Documentation/CodingStyle, and make sure that 
your patch follows the guidelines outlined in those documents.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
