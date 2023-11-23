Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F03EA8
	for <lm-sensors@vger.kernel.org>; Thu, 23 Nov 2023 02:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hG+ayUVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B5DC433C7;
	Thu, 23 Nov 2023 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707411;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=hG+ayUVkzS69/Jeo5x3e73z1CKGKgBzdWyK252jZI+RDXzHcemJiVdoTKr8Luj7GK
	 I3lUxpn446HSZmL/nJAl6TZT/xIGhbmWqarfIOsnvUumtXfXyCf4c1whZSZGBhqelF
	 wBnu6Rk9/ghFS0XysIpnhPBppFWyyctvY2/UmGdk=
Date: Wed, 22 Nov 2023 21:43:29 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: lm-sensors@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-cooperative-binturong-from-sirius-46897d@nitro>
Precedence: bulk
X-Mailing-List: lm-sensors@vger.kernel.org
List-Id: <lm-sensors.vger.kernel.org>
List-Subscribe: <mailto:lm-sensors+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:lm-sensors+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
