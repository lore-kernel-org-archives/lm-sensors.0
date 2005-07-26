From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Tue, 26 Jul 2005 16:35:56 +0000
Subject: [lm-sensors] Re: yani-script
Message-Id: <2538186705072607354f7eb60f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E64292.6060609@divsol.com>
In-Reply-To: <42E64292.6060609@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

There are a few newer (and fixed/updated in some manner or another)
scripts in the lkml/lm-sensors archives you might want to look at,
they are essentially the same idea, but the last revision worked with
some other rare cases and added a device_attribute parameter rather
than a void * as the second argument to the callbacks.

On 7/26/05, Jim Cromie <jcromie@divsol.com> wrote:
> In order to understand the regexs in it, I reformatted one of them
> to use perls x regex modifier, which allows regex code to be
> reformatted for readability.  Then I added comments to the regex.
> 
> here it is, in hopes it will be useful.

This looks useful, my only complaint is that I think you used an older
revision than the one that actually did the massive code change that
was accepted into the mainline kernel. I do at some point intend on
changing the other sysfs attribute callbacks, so its useful for myself
even to have a well documented script to look back at in a few months
:-).

Thanks,
Yani
