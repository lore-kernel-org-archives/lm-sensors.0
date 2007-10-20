From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 20 Oct 2007 22:22:25 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru3-new-motherboards.patch
Message-Id: <471A7FA1.8030703@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <47190047.6020803@hhs.nl>
In-Reply-To: <47190047.6020803@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 20 Oct 2007 11:47:29 +0200, Jean Delvare wrote:
>> On Fri, 19 Oct 2007 21:06:47 +0200, Hans de Goede wrote:
>>> Hi Mark & All,
>>>
>>> This patch adds support for 2 new motherboards to the abituguru3 driver. Its a 
>>> pretty trivial patch and it would be nice if this could make 2.6.24.
>>>
>>> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> Err, I take that back. The patch doesn't even build! List terminators
> are missing, and thankfully closing curly braces do as well, otherwise
> I wouldn't have noticed.
> 
> Hans, when you send patches and insist on having them pushed to Linus
> quickly, you should at least make sure they build and don't cause any
> regression on your own system. Obviously you didn't do that this time :(
> 

Oops,

You are fully right, I was doing a zillion things at once, and didn't test 
build this before sending the patch. My bad, aplogies!

I'll do a new version asap.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
