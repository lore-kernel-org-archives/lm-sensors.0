From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Linux driver for hardware monitor device
Message-Id: <3FD10D50.9010008@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Emmy, let me cc your information to our development team.

The best path to help us is to give us documentation, test hardware 
(eval boards, motherboards, or even computers) and an engineering 
contact we can use to answer any difficult questions we have which the 
datasheets don't address.

Which sensor chips, specificly, are you wishing to help us support?  
What materials could you provide to help us?  What usually happens is a 
person (or two) from our group will volunteer to take on a particular 
sensor chip driver you want us to support and you would ship or email 
any relevent hardware or documentation directly to them and they will do 
the work.  The more you provide/donate, the greater the incentive for a 
developer to step forward and tackle the project, of course.

Oh, and to answer your last question (if I understand it right), at some 
level there must be code which is sensor chip dependant (although that 
code could be in Bios space).  It is possible to link everything 
together and distribute it as one big binary driver file (like your 
Windows driver probably is), but we submit all of our source code in a 
very organized and modular way to make it easier to maintain and 
develop.  Does that make sense?  To the end user, they usually don't 
have to worry about how things have been organized.  They simply run 
'sensors' and it uses the appropriate drivers to talk with the chips 
which are present on their computer.

Thanks for you mail!


Phil

Emmy Smaragda Denton wrote:

>Hi Phil,
>
>I'm the application engineer in charge of hardware monitors at National. I
>would like to find out how to get you to support some of our devices that
>are new and not listed on your site.
>
>We have a new device that is targeted for servers and we have been getting
>quite a few requests for a Linux driver. If you could give me some insight
>on what the best path for me to take I would greatly appreciate it.
>
>We currently have a windows driver that supports all of our devices, it is
>not sensor device dependent. I was wondering why is the Linux sensor driver
>device dependent?
>
>Thanks in advance for any help you can give me!!
>
>Take care,
>
>Emmy Denton
>National Semiconductor
>Temperature Sensor Applications
>408-721-3267
>
>
>
>  
>
