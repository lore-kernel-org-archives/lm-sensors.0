From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 03 Nov 2011 17:00:28 +0000
Subject: Re: [lm-sensors] Fix for ASUS Rampage II GENE
Message-Id: <CAKPcRGpYZm3A4Z66v4+XobVBiDmcbb5YxuVkGe_i3MjAUMO--g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABpR-zTSu4OByNwt_4Muv3s6cS3jf2F5BhWmSPLM6AkVpLCKNg@mail.gmail.com>
In-Reply-To: <CABpR-zTSu4OByNwt_4Muv3s6cS3jf2F5BhWmSPLM6AkVpLCKNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 3, 2011 at 5:53 PM, Crazy Casta <crazycasta@gmail.com> wrote:
> One slight mistake. Apparently w83627ehf does work, but you need a kernel
>>2.6.38 (not sure which version exactly but it works with 3.0.6).

AFAIK only if you disable strict resource enforcing by ACPI subsystem.
The hwmon chip is used by system firmware and safely accessible only
through asus_atk0110 driver.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
