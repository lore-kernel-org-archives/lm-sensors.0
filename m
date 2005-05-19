From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050505080515.GB1993@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 05, 2005 at 02:03:06PM +1000, Grant Coady wrote:
> Hi Yani,
> On Wed, 4 May 2005 23:29:47 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> 
> >                                      It was decided presenting the
> >specific information per file was a much simpler and more sensible
> >interface. I tend to agree.
> Okay, I see that.  also did a 'cat <eeprom>' oops, pipe through xxd 
> 'cos it returned binary data :)  

Yes, some files in sysfs are in binary form.  They are ones that are
only "pass through" type files where the kernel does not modify the data
at all.  Examples of this is the eeprom files, and the pci config space
files.

thanks,

greg k-h
