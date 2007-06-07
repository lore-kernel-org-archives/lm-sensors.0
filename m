From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date: Thu, 07 Jun 2007 14:54:08 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <d120d5000706070754k7cfcb5c3k8a812618f8433495@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/7/07, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Wed, Jun 06, 2007 at 03:07:57PM -0400, Dmitry Torokhov wrote:
> > >
> > >And one would say that the dependency of BAR was not correct.
> > >But kconfig has no way to determine if WHISKEY or VODKA is the right one.
> > >
> >
> > Then it should not allow selecting FOO to begin with.
> >
> > >I understand your input but often the reply is that select was used in the
> > >wrong way.
> >
> > I understand that there are scenarios where select is wrong but I
> > believe here it is theproper construct. Input-polldev is a library
> > module and will never be used on its own, it just provides some
> > services for the drivers (the only reason it even has a visible entry
> > in Kconfig is that there may be out of tree modules using it).
> > Making drivers depend on polldev does not make sense. It also does not
> > make sense for all drivers using services of input-polldev to live in
> > the same directory. Therefore individual drivers attempt to select
> > polldev.
>
> I do not disagree with you - but I have just not got enough gripe
> on the kconfig datastructures to implement the check (yet?).
>

OK, fair enough. I guess I will just move input-polldev from
drivers/input/misc into drivers/input; everything that uses
input-polldev depends on CONFIG_INPUT so that shoudl work.

Hm... do I even need to make it user-visible? Or just hide it
completely and if out-of-tree driver wants to implement polled device
they can do it themselves - it is not a rocket science after all?

-- 
Dmitry

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
