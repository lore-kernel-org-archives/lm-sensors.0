From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: I2C mux / virtual bus implementation
Message-Id: <40DB5FE4.8080009@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40DB5E52.2030902@verizon.net>
In-Reply-To: <40DB5E52.2030902@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(copying the mailing list, already forwarded the first mail to the list)

First I want to ask whether you are working on kernel 2.4 or 2.6.

Second, it sounds like you are on the right track, although I'm not the
best person to give advice on locking... which is why I'm copying the list.

Third, you may not have realized that Khali recently did a (2.4 kernel) pca9540 driver.
It is in our sensors package. It however doesn't do any of the bootstrapping or
bus registering either. It may or may not help you.

mds



Ken Harrenstien wrote:
> Following up on my own msg:
> 
> On Wed, 23 Jun 2004, Ken Harrenstien wrote:
> 
> 
>>What I've done so far is to create "pca954x.c" as a sensors-style chip
>>driver supporting all variants of the PCA954x and keeping a cleaned-up
>>version of Brian's i2c-virtual.c, thus leveraging all the existing
>>code exactly as you suggested.  It's pretty neat, too, and allows
>>multiple levels of virtual busses.
>>
>>However, I suddenly realized that this won't work.  The code will
>>deadlock because the pca954x client is trying to add new "virtual bus"
>>adapters while the core_lists are already locked.  D'oh!
>>
>>In more detail, the typical scenario is that pca954x.o gets loaded,
>>and its _init function promptly calls i2c_add_driver(), which locks
>>core_lists.  Much farther down the line (via driver->attach_adapter to
>>pca954x_attach_adapter() to i2detect() to pca954x_detect()), the mux
>>code tries to create the virtual adapter and calls i2c_add_adapter(),
>>where it locks up since core_lists is locked.  It actually is safe
>>since it's all part of the same thread of control, but the code currently
>>has no way to know that.
>>
>>I'm not quite sure of the best way to resolve this and still conform
>>to the design principles of this package.
>>
>>Add something to bypass the lock?  (Must work for deletes too.)  Add a
>>drivers/i2c/i2c-pca954x.c adapter driver to the mess instead?  Or....?
>>
>>I'm hoping that your vastly greater experience with the i2c/lm_sensors
>>infrastructure will allow you to see the most elegant solution -- in
>>particular, one that you'd be willing to integrate into the package,
>>once I get it working and send in the files/patch.
> 
> 
> Now that I've had some actual quiet time to let my subconscious chew
> on this (and grovel painstakingly through all code paths that touch
> core_lists), I think I have a reasonable solution for bypassing the
> lock: modify i2c-core.c to move the locked parts of i2c_add_adapter()
> and i2c_del_adapter() out into unlocked auxiliary functions, just like
> i2c_check_addr() calls its auxiliary __i2c_check_addr().  Then the
> virtual bus code can call those auxiliaries directly when
> adding/deleting virtual adapters.  That sound reasonable?
> 
> It would be better, though, to use some naming convention for these
> auxiliaries other than prefixing "__", since such symbols are supposed
> to be reserved for the C compiler and its supporting infrastructure.
> How about the clumsy but brutally clear suffix "_unlocked"?
> 
> Unless I hear otherwise, will proceed as above and let you know how
> it goes (probably by Friday, since I'm going to be out Thursday).
> 
> --Ken
> 
