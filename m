From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Close ticket 1131
Message-Id: <3E4AF690.7060107@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302130933.00282.dpnsw@optusnet.com.au>
In-Reply-To: <200302130933.00282.dpnsw@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the contribution.
I've put some of it on the docs.html page and some in doc/i2c-pport in i2c.
mds

David wrote:
> Hi,
> 
> I have raised a ticket about not being able to find how to get the i2c-pcf-epp 
> module. Ticket number 1131. This can be closed as I now know where it is and 
> why it is this way. 
> 
> Maybe you could consider adding a bit of text on the page
> http://www2.lm-sensors.nu/~lm78/docs.html
> under the single paragraph of explanation for the diagram.
> 
> I offer the following for comments, suggestions and corrections. It is 
> something that I feel would have helped me a great deal as I sought to 
> understand the lm_sensors project and would have also avoided me raising 2 
> support requests.
> 
> So here goes::
> 
> The program rectangle is made up of the lm_sensors userspace programs and 
> configuration and documentation files.
> Examples of which are:
> sensors
> sensors-detect
> i2cdetect
> isadump
> sensors.conf
> and associated man pages 
> 
> As you can see from the diagram this is only a small part of a working 
> lm_sensors installation. The rest of the work is done inside the kernel by 
> two branches of lm_sensors that work together, one is called sensors (or 
> should that be sensors2) while the other is i2c. You will need both in order 
> to fully utilise lm_sensors. Depending on what kernel you are using (or more 
> specifically what kernel your distribution has provided to you) will 
> determine what lm_sensors is capable of doing. If you find that you cannot 
> address all of the sensor chips you have or maybe you can't even get 
> i2cdetect to see your adaptor chip then you should check to see if lm_sensors 
> supports your hardware on  
> 
> If your hardware is supported but your current kernel/distribution isn't 
> working then you will probably have to patch and compile the kernel.
> 
> You could just download the latest kernel version from www.kernel.org or get 
> the sources from your distribution. If you do this and compile it, being 
> carefull to configure all the devices you need, you should be aware that even 
> the latest kernel from kernel.org does not have all of the supported sensors 
> and chips in it. To enable a kernel from kernel.org to support all of the 
> sensors, algorithms and adaptors that it is capable of you will need to patch 
> the kernel. Patches are available from http://home.attbi.com/~ac9410/ for the 
> later 2.4 series kernels. 
> 
> You can apply patches by:
> cd path_to_your_kernel_sources
> path -p1 -E < path_to_the_patches/2.4.20-sensors-1-patch
> 
> Do the same for all the sensors and i2c patches you downloaded.
> Note: As patches are prepared against kernels from kernel.org if you are 
> patching against your distribution specific source code there is a 
> possibility that the patches won't cleanly apply. If this is the case you can 
> either try and resolve it manually (if you are capable of doing this), get a 
> kernel from kernel.org or give up and go and do something else.
> 
> Detailed information about compiling & patching the kernel is available at 
> http://en.tldp.org/HOWTO/Kernel-HOWTO.html
> 
> A note about algorithm and adaptor code:
> Most code for algorithm and adaptors are combined into the one module as you 
> need both in order to be able to function correctly. There are a couple of 
> exceptions to this in the form of parallel port adaptors.
> 
> Parallel port adaptors
> Most people don't need to worry about this.
> If you are installing parallel port adaptors it means you are probably messing 
> around with wires and IC's and the like. If you have purchased a card that 
> provides external an external i2c/smbus this will have combined algorithm and 
> adaptor code. If you are doing it yourself by using the parallel port there 
> are basically 2 options.
> 
> 1) Using the parallel port and using the i2c-pport adaptor module and the 
> i2c-algo-bit algorithm module together to enable you to wire up your parallel 
> port to act as an i2c/smbus. This provides a bus that will enable most 
> sensors to work but doesn't support the entire i2c/smbus capability
> 
> 2) Using the parallel port to interface to a Philips PCF8584 parallel to i2c 
> adaptor chip. You will need to build a bit of a circuit to do this. This 
> configuration needs the i2c-pcf-epp adaptor module and the i2c-algo-pcf 
> algorithm module. This support almost all of the i2c/smbus capabilities
> 
> 
> 
> 
> Okay that's it. Did I get it mostly right?
> 
> Turned out a bit longer than I expected. Feel free to use, change or omit as 
> you feel appropriate.
> 
> Many thanks for all your efforts and the project. It is really great (be even 
> better when I get it working ;)
> 
