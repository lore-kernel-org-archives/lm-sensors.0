From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 14:28:54 +0000
Subject: [lm-sensors] [RFC] Improved sensors-detect output
Message-Id: <20060902162854.efb83a50.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060829133558.19eb6bb6.khali@linux-fr.org>
In-Reply-To: <20060829133558.19eb6bb6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself some days ago:
> I am trying to make sensors-detect more user friendly. (...)
> 
> (...) I have a second set of changes which make the output of
> sensors-detect look really different. My goals were:
> 
> * Make the output more compact, as it has grown quite a bit over the
>   past two years with the addition of Super-I/O chip detection and
>   dozens of new chips.
> * Make successful probes more visible, not only for the user but also
>   for us when a user sends the output to us for investigation.
> * Make I2C/SMBus, ISA and Super-I/O probes look more alike.

I'm done with this and my changes are committed. Thanks to all who
contributed feedback, I hopefully integrated it in my work.

Feel free to give a try to the result:
  http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
and comment on it.

-- 
Jean Delvare

