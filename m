From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: Availability of Lm_sensors for custom hardware
Message-Id: <41100287.7090104@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <E29B519C04DC2443BAC819F14AE93F803F1EE8@server02.TANDELSYSTEMS>
In-Reply-To: <E29B519C04DC2443BAC819F14AE93F803F1EE8@server02.TANDELSYSTEMS>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Lm_sensors isn't motherboard/computer specific.  It will support any 
hardware which it has drivers for.  In lm-sensors is a utility called 
"sensors-detect" which will probe your hardware to make a guess as to 
what bus and chip drivers you will need. Start with that.


Phil

Rajesh Brahmankar wrote:
> -->
> 
> Hi,
> 
>  
> 
> I am Rajesh Brahmankar working for Tandel Systems, LLC. We have the 
> customer which requires Node health monitoring tool for Linux cluster 
> having Dual AMD Opteron 240(1.4 Ghz) processor as Compute node, Nortel 
> Networks 5510-48 Gigabit Ethernet Network Switch as interconnect.
> 
> I have the following questions.
> 
> 1. Is Lm_sensor available for above mentioned hardware?
> 
> 2. If not, is it possible to make Lm_sensor working for above mentioned 
> cluster?
> 
> 3. If it is possible then whom to contact further?
> 
>  
> 
> We need your help as soon as possible. If you want to know more hardware 
> details about the cluster then let me know.
> 
>  
> 
> Thanks & Regards,
> 
> Rajesh
> 
