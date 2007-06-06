From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 06 Jun 2007 18:58:15 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <20070606185815.GC6303@uranus.ravnborg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 06, 2007 at 02:39:52PM -0400, Dmitry Torokhov wrote:
> On 6/6/07, Miles Lane <miles.lane@gmail.com> wrote:
> ># CONFIG_INPUT_MISC is not set
> 
> Doesn't kconfig select prerequesites of a "select"ed symbol? If it
> does not I'd consider this a bug.

I does not.
Consider the following:

config FOO
	bool "FOO"
	select BAR

config BAR
	bool "BAR"
	depends on WHISKEY || VODKA

config WHISKEY
	bool "Thirsty?"

config VODKA
	bool "Need to be drunk"


If you choose "FOO" you will get following configuration:
#
# Automatically generated make config: don't edit
# Linux kernel version: 
# Wed Jun  6 20:54:18 2007
#
CONFIG_FOO=y
CONFIG_BAR=y
# CONFIG_WHISKEY is not set
# CONFIG_VODKA is not set

And one would say that the dependency of BAR was not correct.
But kconfig has no way to determine if WHISKEY or VODKA is the right one.

I understand your input but often the reply is that select was used in the wrong way.

	Sam

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
