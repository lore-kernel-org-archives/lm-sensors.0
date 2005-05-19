From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705050822214f3fefd4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/9/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 09 May 2005 00:01, Yani Ioannou wrote:
> > Hi Dmitry,
> >
> > On 5/8/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > Hi Yani,
> > >
> > > Yes, I see what you mean. But I think what we might need is actually 2
> > > void * pointers, something like "attribute_data" and "instance_data".
> > > Macros would initialize "attribute_data" but not "instance_data". This
> > > way their usage is clearly defined and there hopefully less confusion.
> > >
> > > --
> > > Dmitry
> > >
> >
> > The naming might make the distinction in use, but nothing is really
> > stopping anyone from using one or the other and it might even confuse
> > further (i.e. not understanding the difference, using both, using the
> > wrong one). Since the two would be mutually exclusive
> 
> Why would they? Consider something like generic show function you give
> it a pointer to data you want to be printed in instance_data and a pointer
> to format string in attribute_data and that's it.

Each `instance' would have to have it's own sysfs attribute (i.e.
non-static/shared) to be able to set an instance specific pointer
anyway, and so setting attribute_data for bother of those really
doesn't make any sense to me. If you are looking to pass two (or more)
pointers as in your example, just create a single struct containing
them and point to it (although I'm trying not to do something like
that in net-sysfs.c).

Yani
