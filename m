From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Ticket #1633
Message-Id: <20040412125124.5bf00da6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <HW1X4H$02D157720EBB0420D5148E7CB2C5A099@email.it>
In-Reply-To: <HW1X4H$02D157720EBB0420D5148E7CB2C5A099@email.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Khali,
> hope you'll get this email.

Yes, I did :)

> I solved the problem by reinstalling the original kernel rpm:
> 
> # rpm -Uvh --force kernel-2.4.25-ydl-1.rpm
> 
> This makes me think that some part of all the i2c subsystem was
> compiled in the kernel and not as a module.
> 
> Hope this helps, thank you!

Thanks a lot for reporting to us! I've updated the ticket.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
