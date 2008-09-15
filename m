From: Marco Chiappero <marco@absence.it>
Date: Mon, 15 Sep 2008 10:45:52 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48CE3CE0.8050603@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marco Chiappero ha scritto:
> I suspect them to be the iROG marked chips as I think this board is the 
> first Asus mounting such ICs and being capable of showing 
> temperatures/voltages/fan speeds on an external LCD, included with the 
> board. Again, unfortunately no other information is printed.

Sorry for flooding you and the mailing list, please don't hate me, but I 
think I have an interesting news. Today I upgraded a windows program 
called Everest since finally it claims support for the W83667HG chip (it 
was recognized as w83627 in the previous releases), and now it can read 
the whole system informations as the asus utility does. Here is a 
screenshot: http://i36.tinypic.com/9uulc3.png
Is it possibile that all those readings are provided by the single 
Winbond chip? Maybe the w83667hg is not so similar to the w83627dhg...


Marco


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
