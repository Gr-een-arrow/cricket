import Foundation

struct Team{
  public var name: String
  public var balls: Int16 = 0
  public var over: Int16 = 0
  public var wickets: Int16 = 0
  public var oponentScore: Int16 = 0
  public var totalScore: Int16 = 0
  public var chase: Bool = true

  mutating func PreMatch(){
    print("\t\t\t\t\t🔘Game Rules🔘 \n\nOpenent Batting score will be generated automatically...\nWhen batting you have to give a run(1 to 6) as a input, if it matches oponent input, you'll loss a wicket... \nThere will be two overs \n")
     print("\nWanna set a traget or Chase❔: press (b)at or b(o)wl: ")
    var i = true
    while i {
      let tossInput = readLine()
      let toss = tossInput ?? "Error"
      switch toss{
        case "b": 
        self.chase = false
        i = false
  
        case "o":
        self.oponentScore = Int16.random(in: 40...60)
        print("Your Target is: \(self.oponentScore)")
        i = false
        
        default:
        print("Enter Either 'b' or 'o'")
      }
    }  
  }
}

class Batsman{
  let name: String
  var runs: Int16 = 0
  var ballFaced = 0
  var isBatting: Bool = true

  init(_ name: String){
    self.name = name
  }
  

  func ScoreCard(batsman: Int16, bowler: Int16, wicket: Bool = false, target: Bool = false) {
    if India.chase == true{
      print("\t\t\tYour team need \(India.oponentScore - India.totalScore) Runs in \(Int16(12) - (India.balls + Int16(6) * India.over)) Balls")
    }
     else{
    print("\n\t\t\tYou Are Now First Batting")
  }
    print("--------------------------------------------------------")
    print("Batsman: \(batsman)\t\t\tBowler: \(bowler)\n")
    
    if wicket{ print("You are Out ❌!!!  \(India.wickets) Wicket Gone❗️") }
    
    print("--------------------------------------------------------")
    print("Score: \(India.totalScore)\\\(India.wickets) \t\t\tBatting: \(self.name) \t\tOvers: \(India.over).\(India.balls)")
  }
 
  
  var matchSummery = {
    print("\n\n------------------- Match Summery ----------------------\n")
    batsman.map({
      print("\($0.name): \($0.runs)(\($0.ballFaced))")
    })
    print("________________________________________________________")
    print("Total: \(India.totalScore)", terminator: "")
    if India.chase == true{
      if India.oponentScore > India.totalScore{
        print("\t\t\tYour Team Lose ⛔️⛔️⛔️")
      }
      else { print("\t\t\tYour Team Won🏆")
            print("\t\tTarget: \(India.oponentScore)")
      }
    }
    else {
      India.oponentScore = Int16.random(in: 45...65)
      print("\t\t\topponent Total: \(India.oponentScore)")
      if India.oponentScore > India.totalScore{
        print("\n\t\t\tYour Team Lose ⛔️⛔️⛔️")
      }
      else { 
        print("\t\t\tYour Team Won🏆")
      }
    }
  }

    
  func Batting(){
    var wicketResult = false
    battingStart:
    while(self.isBatting) && India.over < 2{
      var bowler = Int16.random(in: 1...6)
      if India.over > 0{
        bowler = Int16.random(in: 4...6)
      }
      
      print("\nEnter your score: ", terminator: "")
      let batterScoreRead = readLine()
      guard let batterScore = batterScoreRead, let batter = Int16(batterScore) else{
        print("Enter Values Between 1 to 6")
        continue battingStart
      }
      guard batter <= 6, batter > 0 else{
        print("Enter valid runs... [1 to 6]")
        continue battingStart
      }
      self.ballFaced += 1
      India.balls += 1
      
      if India.balls == 6 {
          India.over += 1
          India.balls = 0
      }
      
      if batter == bowler{
        India.wickets += 1
        isBatting = false
        wicketResult = true
      }
      else{
        self.runs += batter
        India.totalScore += batter
        
      }
      if India.chase == true{
        if India.oponentScore <= India.totalScore{
          India.oponentScore = 0
          print("You Have won the match!!!")
          break
        }
      }
      ScoreCard(batsman: batter, bowler: bowler, wicket: wicketResult)
    }
  }
}

// ------------------------------------------------------------------//
var batsman: [Batsman] = []
var India = Team(name: "India")
India.PreMatch()
while(India.over < 2 && India.wickets < 5){
  print("\nEnter name of the batsman: ", terminator: "")
  let tempName = readLine()
  let name1 = tempName ?? ""
  let obj = Batsman(name1)
  batsman.append(obj)
  obj.Batting()
  if India.chase == true{
    if India.oponentScore <= India.totalScore{
      break
    }
  }
}
let summery: () = batsman[0].matchSummery()