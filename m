From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Question
Message-Id: <20020214113146.O24643@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Basicly, you insmod the driver, and you should see some files in
/proc/sys/dev/sensors/bt869*/ .  Then, you put your X-server in a NTSC
resolution, and then set the appropriate values in the files in the
directory noted above (e.g. "echo 0 > colorbars", and set ntsc/pal,
resolution, etc.).  Check the output.  If nessesary, you may need to
select the appropriate output port if you don't get anything.  Some
modifications to the driver were recently submitted to CVS (see our
download page for instruction on CVS), so you might try that.

Good luck!


Phil


On Thu, Feb 14, 2002 at 02:26:32PM -0500, Hoopez wrote:
> 
> Hi,                                                                                                                                                       
> I have a question about voodoo 3 cards and s-video tv-out in
> linux that i hope you can answer. I ran through the howto (i'm in america,
> ntsc) and i'm at the point just before you restart the X server. I'm out of sync (or whatever                                                                                  
> you call it), and then when i hit ctrl-alt-number_pad_+, i can see the                                                                                    
> colorbars for one second, until the x server restarts, then it goes back                                                                                  
> to the out-of-sync display. I was wondering if you had any advice on what                                                                                 
> to do or where I should look? I'm running Redhat 7.2 on an Athlon K7,                                                                                     
> Voodoo 3 3000, kernel 2.4.7-10 (i also tried it on 2.4.17)                                                                                                
>                                                                                                                                                           
> If you can help me, thanks, if not, thanks again!                                                                                                         
> Matt Hoopes         

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
