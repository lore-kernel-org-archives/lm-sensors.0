From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <200505090009.09041.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 09 May 2005 00:01, Yani Ioannou wrote:
> Hi Dmitry,
> 
> On 5/8/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > Hi Yani,
> > 
> > Yes, I see what you mean. But I think what we might need is actually 2
> > void * pointers, something like "attribute_data" and "instance_data".
> > Macros would initialize "attribute_data" but not "instance_data". This
> > way their usage is clearly defined and there hopefully less confusion.
> > 
> > --
> > Dmitry
> > 
> 
> The naming might make the distinction in use, but nothing is really
> stopping anyone from using one or the other and it might even confuse
> further (i.e. not understanding the difference, using both, using the
> wrong one). Since the two would be mutually exclusive

Why would they? Consider something like generic show function you give
it a pointer to data you want to be printed in instance_data and a pointer
to format string in attribute_data and that's it.

-- 
Dmitry
