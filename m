From: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 08 Jun 2007 16:07:36 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <Pine.LNX.4.64.0706081804200.1817@scrub.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, 6 Jun 2007, Dmitry Torokhov wrote:

> I understand that there are scenarios where select is wrong but I
> believe here it is theproper construct. Input-polldev is a library
> module and will never be used on its own, it just provides some
> services for the drivers (the only reason it even has a visible entry
> in Kconfig is that there may be out of tree modules using it).

If you select one dependecy you have to select all dependencies. If you 
don't want to repeat a list of selects everywhere, you can use a helper 
config entry, which does this selection and everything else just selects 
this symbol.

bye, Roman

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
