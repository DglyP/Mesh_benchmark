import java.util.Map;
public class RepresentationF_V{
  ArrayList<Vector> vectors;
  HashMap<Integer, ArrayList<Vector>> faces;
  HashMap<Vector, ArrayList<Integer>> listVertex;
  int kind = TRIANGLES;
  public RepresentationF_V(ArrayList<Vector> vectors,int  kind){
    this.vectors = vectors;
    this.kind = kind;
    faces = createFaces();
    listVertex = createListVertex();
  }
  
  public HashMap<Integer, ArrayList<Vector>> createFaces(){
    HashMap<Integer,  ArrayList<Vector>> ans = new HashMap();
     
    for(int i = 0; i < vectors.size() ; i++){
      ArrayList<Vector> vectorsList = new ArrayList();
      for( int j = 0; j < vectors.size()-1 ; j++){
           vectorsList.add(vectors.get((j+i)%vectors.size()));
      }
       ans.put(i, vectorsList);
    }
    return ans;
  }
  
  public HashMap<Vector, ArrayList<Integer>> createListVertex(){
     HashMap<Vector, ArrayList<Integer>> ans = new HashMap();
     
     for(int i = 0; i < vectors.size() ; i++){
      ans.put(vectors.get(i), new ArrayList<Integer>()); 
     }
    for(Map.Entry face : faces.entrySet()){
      ArrayList<Vector> auxV =(ArrayList<Vector>) face.getValue();
      for(int i = 0; i < auxV.size(); i++){
        ArrayList<Integer> aux = ans.get(auxV.get(i));
        aux.add((Integer)face.getKey());
       ans.put(auxV.get(i), aux);
      }
      
    }
    return ans;
  }
  
  public void renderFace(Vector a, Vector b, Vector c){
    beginShape(kind);
      vertex(a.x(), a.y(), a.z());
      vertex(b.x(), b.y(), b.z());
      vertex(c.x(), c.y(), c.z());
    endShape();
  }
  
  public void renderRetainedFace(Vector a, Vector b, Vector c, PShape shape){
    shape.vertex(a.x(), a.y(), a.z());
    shape.vertex(b.x(), b.y(), b.z());
    shape.vertex(c.x(), c.y(), c.z());
  }
  
   public void structInmediateShape(){
   for(Map.Entry face : faces.entrySet()){
      ArrayList<Vector> aux =(ArrayList<Vector>) face.getValue();
     renderFace(aux.get(0),aux.get(1) , aux.get(2));
   }
  }
  
  public PShape structRetainedShape(){
    PShape shape;
    shape = createShape();
      shape.beginShape(kind);
   for(Map.Entry face : faces.entrySet()){
      ArrayList<Vector> aux =(ArrayList<Vector>) face.getValue();
     renderRetainedFace(aux.get(0),aux.get(1) , aux.get(2), shape);
   }
   shape.endShape();
   return shape;
  }

}
