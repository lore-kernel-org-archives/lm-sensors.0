From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 24 Mar 2011 03:33:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (f71882fg) Per-chip
Message-Id: <20110324033356.GB15395@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 23, 2011 at 04:48:41PM -0400, Jean Delvare wrote:
> Use tables to list the count of fan and temperature inputs for all
> supported chips, almost similar to (but more simple than) what is
> already done for voltage inputs. This avoids repeating the same tests
> in different functions, and will make it easier to add support for
> chips with a different count of fan or temperature inputs.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
> Hans, I think this should make adding support for the F81865 easier.
> And it even makes the binary slightly smaller on x86-64. What do you
> think?
> 
I like it. 

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
