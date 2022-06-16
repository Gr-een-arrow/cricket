class Batsman{
  public let name: String = ""
  public var runs: [String: Int] = ["runs": 0, "sixes": 0, "fours": 0]
  public var isBatting: Bool = true

  public func Batting(){
    
  }
}

class Team: Batsman{
  var wickets: Int = 0
  var totalScore: Int = 0
  var currentBatsman: String = ""
  
}

class Result: Team{
  
}