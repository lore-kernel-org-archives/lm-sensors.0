From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Aug 2013 14:59:35 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <20130827165935.294a391b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 27 Aug 2013 20:13:46 +0530, Sachin Kamat wrote:
> Hi Jean,
> 
> On 27 August 2013 19:43, Jean Delvare <khali@linux-fr.org> wrote:
> > I totally agree, I think we want a checkpatch rule for this. I'll ask
> > for it in a separate thread.
> 
> I had already asked Joe to add this as a checkpatch rule. He mentioned
> the following (which I quote):
> "There's no way for checkpatch to look at an __<foo> use
> and determine it should be before or after a variable.
> 
> __scanf, __printf, __cold, etc are often place before
> declarations."

Just because we can't cover all the cases is no good reason to not
cover this one specific problematic case. It's not about __<foo>, only
about "struct __initdata" and "struct __initconst". If grep can find
them, checkpatch should catch them too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
