From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 20:34:38 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <1327437278.2649.202.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2012-01-24 at 14:49 -0500, Jean Delvare wrote:
> On Tue, 24 Jan 2012 10:47:00 -0800, Guenter Roeck wrote:
> > On Tue, 2012-01-24 at 10:11 -0500, Guenter Roeck wrote:
> > > After looking into it a bit more, I think we should move the vrm attributes
> > > to hwmon-vid (and fix hwmon-vid).
> > 
> > Looked into this a bit. I have a list of CPU models, but how do I find
> > out which Intel CPU model supports which VRM version ?
> 
> You have to check the datasheet of every CPU model (or family of
> models) separately. For example, you can get the datasheet for Pentium
> III from:
> http://www.intel.com/design/pentiumiii/datashts/244452.htm
> 
> Then search the document for "VRM", and you'll come to the conclusion
> that it uses VRM 8.4 (which is already supported by hwmon-vid.)
> 
> I'm not sure what you're trying to fix exactly, BTW. The problem I did
> identify is for Intel CPU family 6, models < 0x9. These are currently
> covered by a generic entry in vrm_models[]:
> 
> 	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
> 
> and this should be changed to explicit entries instead, so that the
> generic entry can be removed. But I don't know which of these model
> numbers were actually used (nor what model names they correspond to.)

Most are defined in Intel Application Note 485.

> Well, according to the datasheet above, models 7 and 8 are for the Slot
> 1 version of the Pentium III, but for lower model numbers some research
> will be needed.
> 
Intel CPU model numbers 0x10 and above are not handled correctly. The
code computes eff_model but does not take the extended model number into
account for model 0x06 CPUs (for example, eff_model is computed as 0xa
on my SandyBridge system, when it should be 0x2a). 

Other family 0x6 models I know of so far are:

0x1	Pentium Pro
0x3	Pentium Pro
0x5	Pentium II, Xeon
0x6	Celeron
0x7	Pentium III, Xeon
0x8	Pentium III, Xeon

0x16	Celeron (65 nm)
0x17	Core 2, Xeon (45nm)
0x1A	Core i7 LGA1366 (45nm)
0x1C	Atom (45nm)
0x1D	Xeon MP (45 nm)
0x1E	Core i5, i7 LGA1366 (45nm)
0x1F	Core i5, i7
0x25	Core i3, i5, i7 LGA1156 (32nm)
0x2A	Core i5, i7 2xxx LGA1155 (32nm)
0x2C	Core i7 LGA1366 (32nm) 6 Core
0x2D	SandyBridge Xeon
0x2E	Xeon 7500 (45 nm)
0x2F	Xeon 7500 (32 nm)

Presumably we would want to know the VRM version for those to be able to
support them correctly.

I hoped there was an easier version to find the VRM version than by
searching through the various datasheets.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
