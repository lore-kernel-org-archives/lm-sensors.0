From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Jun 2007 18:29:47 +0000
Subject: Re: [lm-sensors] [i2c] Separate package for i2c tools
Message-Id: <20070627202947.1e0aef5b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625111244.1ca5327a@hyperion.delvare>
In-Reply-To: <20070625111244.1ca5327a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Mon, 25 Jun 2007 11:12:44 +0200, Jean Delvare wrote:
> As part of the libsensors rewrite that is ongoing, the lm-sensors
> package is being reorganized. For example I already deleted all the
> Linux 2.4 kernel drivers that were previously part of the package.
> Another step which I'd like to take is moving the i2c tools to a
> separate package.
> (...)
> We need to find a package name. I propose "i2c-tools". Objections?
> 
> We also need to agree on which files should be moved. Some parts of the
> (current) lm-sensors package clearly belong to the new i2c tools
> package: i2cdetect, i2cdump, i2cget, i2cset, ddcmon, decode-dimms.pl,
> decode-edid.pl, decode-vaio.pl, decode-xeon.pl, eepromer/*, py-smbus/*,
> i2c-dev.h.

OK, this is done now.

>            For some others it's not so clear.
>
> * isadump, isaset: Not strictly sensors-specific, but not i2c-related
> either. They share their command line syntax and a very small amount of
> code with i2cdump. I'd rather leave them where they are.
> 
> * unhide_ICH_SMBus: Not strictly sensors-specific, but I don't think
> people really need this unless they are trying to get their sensors to
> work. No opinion.
> 
> * matorb/*: Last touched 8 years ago. Hmm, delete?
> 
> * mkdev.sh: Not strictly sensors-related, but the FAQ, INSTALL and
> sensors-detect refer to it. It probably doesn't really matter as these
> device nodes are created by udev nowadays. No opinion.

I didn't touch these yet, so this can still be discussed.

> I plan to remove the dependency between sensors-detect and i2cdetect as
> part of this change, otherwise we lose much of the benefit.
> sensors-detect only uses i2cdetect to list the available i2c buses, it
> should be easy to do the same in perl directly.

This is done too. I even backported this change to lm-sensors/trunk, as
I am trying to keep sensors-detect in sync for now.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
