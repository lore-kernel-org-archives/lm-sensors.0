From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 31 May 2011 16:13:38 +0000
Subject: Re: [lm-sensors] max1668 support revisited
Message-Id: <20110531161338.GA27119@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTi=0dC7=naE2wY6Wf5scaAtzT9bGwQ@mail.gmail.com>
In-Reply-To: <BANLkTi=0dC7=naE2wY6Wf5scaAtzT9bGwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 31, 2011 at 11:19:00AM -0400, David George wrote:
> Hi All.
> 
> I have written a kernel driver for the Maxim part MAX1668, which I
> have attached to this email. I have tested this code on a MAX1805 and
> it seems to work.
> 
> I'm not really sure how to go about publishing it and was hoping for
> some advice from this list.
> 
> Kind regards,
> David
> 
> 
Hi David,

The easiest way to proceed would be for you to read and follow the guidelines 
in Documentation/hwmon/submitting-patches; this would also save us a lot of time.

Browsing through the code, you have forward declarations, your formatting is a off,
you have undocumented ABI attributes (temp_fault_open, temp_fault_alarm), you have a 
deprecated ABI attribute (alarms), you generate ABI attributes for non-existing sensors
on MAX1805, you don't check for error returns from i2c functions, and your detect
function (even though only if debug is enabled) is noisy. The detect function reads
status and config registers but does not use the results.

The usage of temp_max and temp_min is inconsistent. You set it to the temperature 
in degrees C in the set functions, yet convert it to milli-degrees C when reading it.
For that I would recommend to keep all the stored values in degrees C and multiply
with 1000 when displaying temperatures.

If you follow the above mentioned guidelines and fix the problems I have mentioned,
we'll have something to work with for further review.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
