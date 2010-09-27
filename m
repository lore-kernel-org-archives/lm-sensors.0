From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Sep 2010 23:44:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon (coretemp): Fix build breakage if
Message-Id: <AANLkTinDkJu2MSJM6bUpWJoB2XOD4LLf6GTPBX39wteD@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="005045029d3ccd4ca90491464e06"
List-Id: <lm-sensors.vger.kernel.org>
References: <1285588796-20956-1-git-send-email-guenter.roeck@ericsson.com>
 <20100927125946.GB2862@elte.hu> <AANLkTinPHP8WhoAZQqcmhotEfFa6=mG_Acy+xCBQ0_5+@mail.gmail.com>
 <20100927232716.GB4744@ericsson.com>
In-Reply-To: <20100927232716.GB4744@ericsson.com>
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>

--005045029d3ccd4ca90491464e06
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Sep 27, 2010 at 4:27 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Mon, Sep 27, 2010 at 09:02:57AM -0400, Pekka Enberg wrote:
>> On Mon, Sep 27, 2010 at 3:59 PM, Ingo Molnar <mingo@elte.hu> wrote:
>> >
>> > * Guenter Roeck <guenter.roeck@ericsson.com> wrote:
>> >
>> >> +#ifdef CONFIG_SMP
>> >> +#endif
>> >> +#ifdef CONFIG_SMP
>> >> +#endif
>> >
>> > Hm, this tickles my uglo-meter. Is there no cleaner way, preferably one
>> > that doesnt involve preprocessor directives?
>>
>> Implement cpu_sibling_mask() on UP so that the loop goes away?
>
> So what is the take ? Looks like Linus won't accept my patch without someone
> else signing off on it. If the uglo-meter prevents it from being accepted,
> I'll be happy to submit the SMP cleanup patch instead. As I mentioned
> before, I would prefer that to go into -next.

I'd _much_ rather see cpu_sibling_mask() on UP, and just have the loop go away.

But that would be a generic change. Something like the (UNTESTED!)
attached. It returns a NULL, since it would always be a bug to
actually _use_ the (nonexistent) mask. And that's fine for things like
for_each_cpu() that will then happily ignore the mask.

Ingo, does this make those randconfig things work? I think it's
prettier than the horrible "sprinkle #ifdef CONFIG_SMP around in
random places".

                        Linus

--005045029d3ccd4ca90491464e06
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gelzh08d0

IGluY2x1ZGUvbGludXgvc21wLmggfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NtcC5o
IGIvaW5jbHVkZS9saW51eC9zbXAuaAppbmRleCBjZmEyZDIwLi5hZDQ4MDc3IDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L3NtcC5oCisrKyBiL2luY2x1ZGUvbGludXgvc21wLmgKQEAgLTE0OSw2
ICsxNDksOCBAQCBzbXBfY2FsbF9mdW5jdGlvbl9hbnkoY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1h
c2ssIHZvaWQgKCpmdW5jKSh2b2lkICppbmZvKSwKIAlyZXR1cm4gc21wX2NhbGxfZnVuY3Rpb25f
c2luZ2xlKDAsIGZ1bmMsIGluZm8sIHdhaXQpOwogfQogCitzdGF0aWMgaW5saW5lIGNvbnN0IHN0
cnVjdCBjcHVtYXNrICpjcHVfc2libGluZ19tYXNrKGludCBjcHUpIHsgcmV0dXJuIE5VTEw7IH0K
KwogI2VuZGlmIC8qICFTTVAgKi8KIAogLyoK
--005045029d3ccd4ca90491464e06
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--005045029d3ccd4ca90491464e06--
