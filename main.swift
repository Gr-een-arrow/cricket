struct Team{
  public var name: String
  public var balls = 0
  public var over: Int16 = 0
  public var wickets: Int16 = 0
  public var totalScore: Int16 = 0
}

class Batsman{
  let name: String
  var runs: [String: Int16] = ["runs": 0, "sixes": 0, "fours": 0]
  var ballFaced = 0
  var isBatting: Bool = true

  init(_ name: String){
    self.name = name
  }

  func ScoreCard(batsman: Int16, bowler: Int16, wicket: Bool = false) {
    print("\n\nOvers: \(India.over).\(India.balls)")
    print("----------------------------------------------------")
    print("Batsman: \(batsman)\t\t\tBowler: \(bowler)\n")
    if wicket{print("You are Out!!!  \(India.wickets) Wicket Gone")}
    print("----------------------------------------------------")
    print("Score: \(India.totalScore)\\\(India.wickets) \t\t\tBatting: \(self.name)")
  }

  // func MatchSummary(){
  //   print(batsman.map({
  //     print("\n\n--------------------------------------------------\n")
  //     print("\($0.name): \($0.runs["runs"])(\($0.ballFaced))")
  //   }))
  // }

  let Targetgenerator = { return Int16.random(in: 30...48) }
    
  func Batting(){
    let Bowler = { return Int16.random(in: 1...6) }
    battingStart:
    while(self.isBatting) || India.over < 2 {
      let batterScoreRead = readLine()
      guard let batterScore = batterScoreRead, let batter = Int16(batterScore) else{
        print("Enter Values Between 1 to 6")
        continue battingStart
      }
      let bowler = Bowler()
      self.ballFaced += 1
      India.balls += 1

      if India.balls == 6{
          India.over += 1
          India.balls = 0
        }
      
      if batter == bowler{
        India.wickets += 1
        isBatting = false
        ScoreCard(batsman: batter, bowler: bowler, wicket: true)
      }
      else{
        India.totalScore += batter
        ScoreCard(batsman: batter, bowler: bowler)
        isBatting = false
      }
    }
  }
}


var batsman: [Batsman] = []
var India = Team(name: "India")
while(India.over<2 || India.wickets<5){
  print("Enter name of the batsman: ", terminator: "")
  let tempName = readLine()
  let name1 = tempName ?? ""
  let obj = Batsman(name1)
  obj.Batting()
  batsman.append(obj)
  break
}
// batsman[0].MatchSummary()