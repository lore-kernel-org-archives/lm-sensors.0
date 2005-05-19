From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050510000334.GA24769@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 09, 2005 at 06:34:24PM -0400, Yani Ioannou wrote:
> Hi Jean,
> 
> On 5/9/05, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Yani,
> > 
> > You could always define a static array of pointers, and use the passed
> > int as an index to that array, thus converting the int into a pointer.
> > It's not very different from defining a static array of ints and passing
> > the int addresses as the void*, but for some reason I tend to prefer the
> > int -> pointer conversion (most certainly because my view if awfully
> > biased by my misknowledge of the kernel except for the i2c and hardware
> > monitoring code).
> 
> Yes, so it is possible just very ugly :-). I'm not sure what I think
> of the int->pointer conversion, I guess its a necessary evil. I can't
> help feel like I'm doing something wrong when I do it though..

Storing an int or a long in a pointer is just fine, don't feel dirty,
it's a natural thing :)

More comments on your main patch in a bit...

thanks,

greg k-h
