From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <sflFHE0W.1105691432.8006290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41E718CA.3070305@edgedesign.us>
In-Reply-To: <41E718CA.3070305@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Phil, hi Axel,

> Please see below for our conversation on Bugzilla topics.  Comments
> wanted!

First of all, thanks a lot for working on this. I will be very happy when
we finally move from our old ticket system to bugzilla :) Don't get me
wrong, the old ticket system isn't all bad and I appreciate the work
that was made on it, but the limitations it had (no possible follow-up
by the submitter to name only the major one) made it hard to use
efficiently.

> I'm thinking 'i2c' and 'lm_sensors' for the products. And then breaking
> out each driver (chip and bus) for the components, each app in 'prog'
> (e.g. 'i2c-detect','sensors-detect',etc.) and adding either a catchall
> for the rest of the code or breaking them out further (e.g. 'dev',
> 'proc', 'core', etc.).
>
> What do you think?

What are these "Products"? When looking at the kernel's bugzilla I see
categories and components within the categories, but no products.

http://bugzilla.kernel.org/query.cgi

I am not sure that formally splitting i2c and lm_sensors as products is
wise. There are a couple bus drivers in the i2c package while the other
ones are in lm_sensors. Also, the split between i2c and lm_sensors might
not be clear to the user so it might confuse them more than help.

> I wished there were a hierachical structure in components, so that one
> could use
>
> |-->chips
> |  |-->...
> |  |-->...
> |-->busses
>
> but there isn't, it has to be kept flat (or we embed the hierachy in
> the components like "chips:lm93").

I would use the Categories for that. I would propose the following
categories, with non-exhaustive components lists:

i2c core drivers
    |--> i2c-core
    |--> i2c-proc
    |--> i2c-dev
    |--> i2c-isa
bus drivers
    |--> i2c-ali15x3
    |--> i2c-ali1535
    |--> i2c-i801
    |--> i2c-viapro
    |--> ...
chip drivers
    |--> adm1021
    |--> adm1025
    |--> adm1031
    |--> it87
    |--> lm63
    |--> lm75
    |--> lm80
    |--> lm83
    |--> lm85
    |--> lm87
    |--> lm90
    |--> lm92
    |--> lm93
    |--> via686a
    |--> vt1211
    |--> vt8231
    |--> w83781d
    |--> w83627hf
    |--> ...
userspace tools
    |--> sensors
    |--> sensord
    |--> sensors-detect
    |--> i2cdetect
    |--> i2cdump
    |--> i2cset
    |--> isadump
    |--> isaset
    |--> ddcmon
    |--> ...

I guess it somehow covers the hierarchical structure you were thinking of.

> The main purpose of components is for developers to be auto-assigned
> them and to be able to sort easier through the bugs.

Completely agree. It would help much if we could all get an alert when
one of "our" drivers gets a report, instead of having to watch the
tickets as they are created and ignore those we don't feel competent
for.

Thanks again,
--
Jean Delvare
