class MemberShipCurrency {
  int totalPointsRedeemed;
  int totalPointsExpired;
  int totalPointsAccrued;
  int balanceBeforeReset;
  int expirationPoints;
  int pointsBalance;
  String membershipCode;
  MemberShipCurrency(
      this.totalPointsRedeemed,
      this.totalPointsExpired,
      this.totalPointsAccrued,
      this.balanceBeforeReset,
      this.expirationPoints,
      this.pointsBalance,
      this.membershipCode);
}
