From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <2538186705050822013a73e10a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dmitry,

On 5/8/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> Hi Yani,
> 
> Yes, I see what you mean. But I think what we might need is actually 2
> void * pointers, something like "attribute_data" and "instance_data".
> Macros would initialize "attribute_data" but not "instance_data". This
> way their usage is clearly defined and there hopefully less confusion.
> 
> --
> Dmitry
> 

The naming might make the distinction in use, but nothing is really
stopping anyone from using one or the other and it might even confuse
further (i.e. not understanding the difference, using both, using the
wrong one). Since the two would be mutually exclusive I also can't
help feel it would be a waste of space. Maybe naming the macro that
sets the data member to something appropriate would help?

I think a brief comment on the matter in device.h and further
explanation in the sysfs documentation might be as far as we could go,
I don't see a nice way to enforce something like this. Its a difficult
decision, but sometimes we just have to trust people read the
documentation and know what they are doing (and peer review).

Yani

(P.S. net/core/net-sysfs.c wasn't the best example in my previous
message - its not as easy to change as it first looks)
