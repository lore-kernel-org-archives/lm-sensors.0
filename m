From: jukka.hynninen@vaisala.com
Date: Fri, 25 Mar 2011 12:51:20 +0000
Subject: [lm-sensors] Chip Addition: ITE IT8783F
Message-Id: <B9D3C48C98930741A166756A50C44A611FF696B3@helx1.corp.vaisala.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Running sensors-detect on Atom-based industrial Moxa V2101 yielded:

Trying family `ITE'...                                      Yes
Found unknown chip with ID 0x8783
    (logical device 4 has address 0x290, could be sensors)

Seems that the Super-IO chip under the hood is ITE IT8783F. 

Anyone interested in adding support for this? I'd be glad to assist on
further evaluation and testing.


-Jukka

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
