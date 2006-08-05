From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Sat, 05 Aug 2006 03:43:42 +0000
Subject: [lm-sensors] Adding userspace support for ipmisensors
Message-Id: <253818670608042043n1177c25fw77b10678b8b9e937@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
In-Reply-To: <253818670608031201l3e101782r5d1012900ddecdf8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 8/4/06, Jean Delvare <khali at linux-fr.org> wrote:
> We can obviously apply this, it's not very intrusive ;) However, may I
> ask why you didn't simply keep the "bmc" prefix? You would have won
> compatibility with a few previous releases of lm_sensors, and the name
> change might also confuse the users.

Yes, I was kind of expecting someone to ask about eventually ;). Lets
see if I can explain my rationale without it sounding like an
arbitrary decision that sounded good at 4am.

ipmisensors has very little in common with bmcsensors (other than the
IPMI messaging code thats stayed the same of course) and is very much
a re-write, so much so I decided at some point it would actually be
more of a confusion for it to have the same name.

- bmcsensors required i2c-ipmi to load (due to the horrible old
client-bus i2c hack), while ipmisensors is a standalone hwmon driver,
and I think the new name would reflect that well.

This was the main reason - to clearly show ipmisensors does not
require i2c-ipmi. It also means previous lm_sensors releases of
sensors-detect would not provide the right instructions for loading
ipmisensors even if it had the same name.

- the vast majority of the new features already in bmcsensors
(unlimited sensors determined at runtime for example) and any I plan
to add to ipmisensors in future will be virtually impossible to back
port to bmcsensors unless they are just IPMI messaging related.
(hwmon, dynamic callbacks, the extra ipmi subsystem support aren't
available in 2.4).

- given the different IPMI implementations that are coming out, mBMC
for example I thought ipmisensors was a little bit more clear on the
purpose of the driver - querying sensors over a local IPMI interface
rather than any specific form of a BMC.

Saying all that though you have a good point in that it could even
have a different name but retain the bmc prefix, although I can't
think of a different name that sounds any good with the same prefix, I
welcome suggestions & opinions on the rename.

Considering that ipmisensors will require 2.6.17 and above, I
personally haven't been so concerned on backwards compatibility with
older versions of lm_sensors userspace.

> Secondly, make sure you created a "name" attribute with the chip type
> (that would be "ipmi" for you) for your device.
Ah, I think that's the problem, thanks! I'll be sending you the patch
once I get userspace working and a few more people have tested it.
There is only one other issue I know of and am trying to track down.

> For now, yes. However there are plans floating around to have
> libsensors probe for chip features (Linux 2.6 only) instead of using an
> internal hard-coded list for every chip. That's what Mark M. Hoffman
> and I had been discussing at the restaurant in Ottawa, if you remember.
> I know Hans de Goede has interest in this too, unfortunately I'm a bit
> too busy right now to go on.
Yes, that sounds promising. I'll just use the bmcsensors defines in
chips.[ch] then for now.

> > - binary sensors
> > IPMI supports "non-threshold sensors" for things like power status,
> > chassis intrusion, etc, which are basically binary valued.
>
> You mean _booleans_?
Yes.

> The extra attributes (e.g. chassis intrusion) might lack proper
> standardization at the moment, though.
Something to think of for later then, but I think most people will be
happy with just the integer 0/1 being reported for now.

Thanks,
Yani

