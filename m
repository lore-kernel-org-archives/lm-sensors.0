Return-Path: <lm-sensors-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAF8C4332F
	for <lm-sensors@archiver.kernel.org>; Thu,  9 Nov 2023 08:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjKIIk1 (ORCPT <rfc822;lm-sensors@archiver.kernel.org>);
        Thu, 9 Nov 2023 03:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKIIk1 (ORCPT
        <rfc822;lm-sensors@vger.kernel.org>); Thu, 9 Nov 2023 03:40:27 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDDF1FFB
        for <lm-sensors@vger.kernel.org>; Thu,  9 Nov 2023 00:40:25 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so325540a34.0
        for <lm-sensors@vger.kernel.org>; Thu, 09 Nov 2023 00:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699519224; x=1700124024; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0R1S1mJjoANo2SzvXhgkPyNgGJQHqmIg9xVfjekNaw=;
        b=A69UOEBhudgUPaiKjzd/REC9q114+lguTqsvF6nohLuGL3YkWHUcGjlzueOXa0UHzO
         NeeL03gh4n8w1aeCl2dkQODnceuTRwTm/FMjn3SzD5TTIyjL0Q/ACS1whkiXeIMZXNxw
         m6TnnDUyOr8QWxSCEzAKf6uDQ8wG2aqRRSNpL8mh7SE5TiOrmRkldXLlPPrIObI+RtuA
         RqSzEPGCOhaAfNBHH8OJaxVu8QwvpWhhoWXE6EKdJISKJ6uugWCNuFsPr12hTzXnm1Cj
         yiJcWJzQsPEja2XOwE3AT1pn90kXVLNVKLJsG/s9prwpREPgfEydS4T8D1lWNdb0lTE/
         M1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699519224; x=1700124024;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0R1S1mJjoANo2SzvXhgkPyNgGJQHqmIg9xVfjekNaw=;
        b=Y5egYhscp65eplqkv+hZ4QXRzqAm+u5aXXqTRR3VjP/SWTXTxJnGgzSbF6ig8+ro5D
         y4tjojJ4amTRnNLz/LPOO1+NnGbUZQRAR9dXtbSRrphrXn5Nb12VSkSrgRxdJ0UXqTVX
         KJ9ecwBdrlVuhIjrdvhPedoPW5qVWVylGmxCITwirb8pImfXam44zitbVRGbqotr3Yby
         aVYaR6UZ+FpGuq1G5z8NbieWu97ZiteI8N+B+dtEHJy+LS0+V/Z3wgsTeSmiAHQRpobe
         2obKj6t7JvOJio2iLZTmR7/E+NK5vfoEHidRhir+VqteG7mIPGBArZyTK6PpzqFqQgez
         6e2A==
X-Gm-Message-State: AOJu0YwNPfRQT9Dm6TvSke/s0R6/xEPLkHlQ9c5p+nFYfhYE/ZXVkMPN
        yL3g9SPbhl/FlbsHNkLj7suCE+d+NZWMaMHKjXUvWSPPHfM=
X-Google-Smtp-Source: AGHT+IEQ4zPtKDy/0ZV6nF2zSoJXW/HFRTO5NcuB+3E3uo7aPwz7gzaeVbFcOm6hig6mA2C3AaH9+1GNOL1iz0bCsxY=
X-Received: by 2002:a05:6830:348a:b0:6d4:726f:689f with SMTP id
 c10-20020a056830348a00b006d4726f689fmr4679463otu.6.1699519223958; Thu, 09 Nov
 2023 00:40:23 -0800 (PST)
MIME-Version: 1.0
From:   Rabindra Paikaray <rabipaikaray@gmail.com>
Date:   Thu, 9 Nov 2023 14:10:12 +0530
Message-ID: <CACDPk2F2XKL=OpNx-bYnoPfXcR0B0Yv0fe8Uwnyz2PjO___Osw@mail.gmail.com>
Subject: Fan speed rpm not appearing in sensor
To:     lm-sensors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <lm-sensors.vger.kernel.org>
X-Mailing-List: lm-sensors@vger.kernel.org

Hi ,
I am using Ubuntu 22.04 in a Intel platform to fetch the Fan speed rpm
in lm_sensor. I installed the lm sensor module.

Output of sensor command:
$ sensors
coretemp-isa-0000
Adapter: ISA adapter
Package id 0:  +31.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 0:        +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 4:        +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 8:        +29.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 12:       +26.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 16:       +29.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 20:       +29.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 24:       +25.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 28:       +27.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 36:       +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 37:       +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 38:       +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)
Core 39:       +28.0=C2=B0C  (high =3D +80.0=C2=B0C, crit =3D +100.0=C2=B0C=
)

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +32.0=C2=B0C  (crit =3D +105.0=C2=B0C)

nvme-pci-0200
Adapter: PCI adapter
Composite:    +28.9=C2=B0C  (low  =3D  -5.2=C2=B0C, high =3D +79.8=C2=B0C)
                       (crit =3D +84.8=C2=B0C)

I could see the fan is listed in acpi device
$ cat /sys/bus/acpi/devices/INTC1048:00/fan_speed_rpm
1145

I was not getting why the fan speed rpm not appearing in sensors list.

Are there any modules/steps  missing?

Any help or pointer will be helpful?
